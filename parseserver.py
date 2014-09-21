import json,httplib,urllib,time
from datetime import datetime
from twilio.rest import TwilioRestClient 

paid = "CPn8KR1uKfa6UPvC6uBaWmBhDO9qqX2tKj6CvI26"
prak = "TjBu4NLP2XOXwmsJOers9XCvytz0tvQ8gctr11n7"
ACCOUNT_SID = "ACef266da6b48baf8671ea2baf6c2b1f38" 
AUTH_TOKEN = "3dc3dbc60091a2a9c9149687091b8e30" 

client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN) 
connection = httplib.HTTPSConnection('api.parse.com', 443)
connection.connect()

while True:
	connection.request('GET', '/1/classes/Deadline', '', {
	       "X-Parse-Application-Id": paid,
	       "X-Parse-REST-API-Key": prak
	     })
	result = json.loads(connection.getresponse().read())['results']
	for deadline in result:
		dateob = datetime.strptime(deadline['scheduledDate'].replace(" +0000",''), '%Y-%m-%d %H:%M:%S')
		#check if the deadline has passed:
		if dateob < datetime.utcnow():
			print deadline['title'] + "  -  " + str(datetime.utcnow())
			#send sms message:
			params = urllib.urlencode({"username":deadline['username']})
			connection.request('GET', '/1/users?%s' % params, '', {
			       "X-Parse-Application-Id": paid,
			       "X-Parse-REST-API-Key": prak
			     })
			name = json.loads(connection.getresponse().read())['results'][0]['fullName']
			client.messages.create(
				to_=deadline['phoneNumber'],
				from_="+12268871449",
				body_=name+" has not been going to class."
			)
			#remove the event:
			connection.request('DELETE', '/1/classes/Deadline/'+deadline['objectId'], '', {
		       		"X-Parse-Application-Id": paid,
		       		"X-Parse-REST-API-Key": prak
		     	})
			delresult = json.loads(connection.getresponse().read())

	time.sleep(5)
