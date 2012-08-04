# coding=utf-8

from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response
from pyramid.httpexceptions import HTTPNotFound

import json
from pymongo import Connection
import gocardless

app_id="41QYK5M5DXA2E6GR86QVDSN2HT533JXGH9XZRZNTD483XAFE8K7S7TDDHZ4HBFSE"
app_secret="72XZJPB898KWV4PHAYMG77DCGBMHRJW0RJDJGTR179XY9G4YNYAPK7G8QDGP7PDB"

pm_connection = Connection()
db = pm_connection.lannyapp

def reset_db():
	luigi  = {
		'_id': '2c45d4d6-7427-45ca-88ed-3d7f275646b6',
		'name': "Luigi",
		'access_token': 'E22AW3Y80PZA7274S69Z501PHST5ANVY1WG8NAA13DY30APVGF7JZPVKY8E8RGA7',
		'merchant_id': '052B43WCFC'}
	pm_connection.drop_database('lannyapp')
	users = db.users
	users.insert(luigi)

def get_user(id):
	users = db.users
	user = users.find_one({'_id': id})
	if user == None:
		raise Exception("User not found")
	else:
		return user

def get_client(id):
	recipient = get_user(id)
	return gocardless.Client(app_id=app_id, app_secret=app_secret, merchant_id=recipient['merchant_id'], access_token=recipient['access_token'])

def payment_url(request):
	try:
		recipient = get_client(request.matchdict['recipient'])
	except Exception:
		return HTTPNotFound("Recipient not found")

	url = recipient.new_bill_url(amount=request.matchdict['amount'], name="Tip from Lannyapp")
	return Response(json.dumps({'paymentURL':url}))

if __name__ == '__main__':
	gocardless.environment = "sandbox"
	#reset_db()

	# Pyramid
	config = Configurator()
	config.add_route('pay', '/pay/{sender}/{recipient}/{amount}')
	config.add_view(payment_url, route_name='pay')
	app = config.make_wsgi_app()
	server = make_server('0.0.0.0', 8080, app)
	server.serve_forever()
