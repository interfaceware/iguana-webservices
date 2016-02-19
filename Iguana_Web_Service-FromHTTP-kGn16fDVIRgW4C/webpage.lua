local Webpage = {}

Webpage.text = [[   
<h1>
   Iguana acting as a webservice
</h1>

<p>To use this web service, please supply the following parameters:</p>

<ul>
   <li>
      <b>LastName:</b> Please provide the last name of the patient you would like to find.
   </li>
   <li>
      <b>Format:</b> Please specify if you would like your results in XML or JSON format
   </li>
</ul>

<p>The following are pre-formatted requests that you can use to search for a patient with the last name "Smith".  Just click and go!</p>

<p>
   Return the results as XML: <a href='?LastName=Smith&Format=xml'>http://localhost:6544/lookup?LastName=Smith&Format=xml</a><br>
   Return the results as JSON: <a href='?LastName=Smith&Format=json'>http://localhost:6544/lookup?LastName=Smith&Format=json</a>
</p>
]]

return Webpage

