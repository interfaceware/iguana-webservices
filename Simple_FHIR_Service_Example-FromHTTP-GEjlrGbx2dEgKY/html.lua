local html = {}

html.default = [[
<!DOCTYPE html>
<html>
<head>
   <title>Simple FHIR Service Example</title>
</head>
<body>
   <h1>Simple FHIR Service Example</h1>
   <p>The following example demonstates a FHIR read (GET) request to retrieve a single FHIR patient resource in JSON with id='example'.</p>
   <p>To initiate the request and display the data, simply click the link below...</p>
   <a href="/fhir_example/patient/example">Get the resource at --> /fhir_example/patient/example</a>
</body>
</html>
]] 

html.invalidRequest = [[
<!DOCTYPE html>
<html>
<head>
   <title>Simple FHIR Service Example</title>
</head>
<body>
   <h1>Invalid Request</h1>
</body>
</html>
]]

return html