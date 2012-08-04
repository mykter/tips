# coding=utf-8

from wsgiref.simple_server import make_server
from pyramid.config import Configurator
from pyramid.response import Response

import json

import gocardless

app_id="41QYK5M5DXA2E6GR86QVDSN2HT533JXGH9XZRZNTD483XAFE8K7S7TDDHZ4HBFSE"
app_secret="72XZJPB898KWV4PHAYMG77DCGBMHRJW0RJDJGTR179XY9G4YNYAPK7G8QDGP7PDB"
luigi = {}
luigi['access_token'] = 'E22AW3Y80PZA7274S69Z501PHST5ANVY1WG8NAA13DY30APVGF7JZPVKY8E8RGA7' 
luigi['merchant_id'] = '052B43WCFC'

def get_client(id):
	return gocardless.Client(app_id=app_id, app_secret=app_secret, **luigi)

def payment_url(request):
	recipient = get_client(request.matchdict['recipient'])
	url = recipient.new_bill_url(amount=request.matchdict['amount'], name="Tip from Lannyapp")
	return Response(json.dumps({'paymentURL':url}))

if __name__ == '__main__':
	gocardless.environment = "sandbox"

	# Pyramid
	config = Configurator()
	config.add_route('pay', '/pay/{sender}/{recipient}/{amount}')
	config.add_view(payment_url, route_name='pay')
	app = config.make_wsgi_app()
	server = make_server('0.0.0.0', 8080, app)
	server.serve_forever()
