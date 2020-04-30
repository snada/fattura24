var search_data = {"index":{"searchIndex":["fattura24","api","response","configuration","documenttype","error","invalidparams","missingapikey","missinginput","notserializable","utils","code()","configuration()","configure()","crush()","crush_array()","crush_hash()","get_file()","get_numerator()","get_pdc()","get_product()","get_template()","message()","new()","new()","pdf?()","request()","save_customer()","save_document()","save_item()","success?()","test_key()","to_h()","to_s()","readme"],"longSearchIndex":["fattura24","fattura24::api","fattura24::api::response","fattura24::configuration","fattura24::documenttype","fattura24::error","fattura24::invalidparams","fattura24::missingapikey","fattura24::missinginput","fattura24::notserializable","fattura24::utils","fattura24::api::response#code()","fattura24::configuration()","fattura24::configure()","fattura24::utils::crush()","fattura24::utils::crush_array()","fattura24::utils::crush_hash()","fattura24::api::get_file()","fattura24::api::get_numerator()","fattura24::api::get_pdc()","fattura24::api::get_product()","fattura24::api::get_template()","fattura24::missingapikey#message()","fattura24::api::response::new()","fattura24::configuration::new()","fattura24::api::response#pdf?()","fattura24::api::request()","fattura24::api::save_customer()","fattura24::api::save_document()","fattura24::api::save_item()","fattura24::api::response#success?()","fattura24::api::test_key()","fattura24::api::response#to_h()","fattura24::api::response#to_s()",""],"info":[["Fattura24","","Fattura24.html","",""],["Fattura24::Api","","Fattura24/Api.html","",""],["Fattura24::Api::Response","","Fattura24/Api/Response.html","","<p>An instance of this class will be returned on every api call, wrapping the content of the response and …\n"],["Fattura24::Configuration","","Fattura24/Configuration.html","",""],["Fattura24::DocumentType","","Fattura24/DocumentType.html","","<p>This module contains constants to be used when creating documents/credits.\n"],["Fattura24::Error","","Fattura24/Error.html","",""],["Fattura24::InvalidParams","","Fattura24/InvalidParams.html","",""],["Fattura24::MissingApiKey","","Fattura24/MissingApiKey.html","","<p>Thrown when trying to perform any request on the api without a key set in configuration\n"],["Fattura24::MissingInput","","Fattura24/MissingInput.html","",""],["Fattura24::NotSerializable","","Fattura24/NotSerializable.html","",""],["Fattura24::Utils","","Fattura24/Utils.html","",""],["code","Fattura24::Api::Response","Fattura24/Api/Response.html#method-i-code","()","<p>Returns the <code>Integer</code> value of the underlying http request. It does not mean the request performed it&#39;s …\n"],["configuration","Fattura24","Fattura24.html#method-c-configuration","()","<p>Returns current configuration object\n"],["configure","Fattura24","Fattura24.html#method-c-configure","()","<p>Calling this method will yield to a block passing the <code>configuration</code> object as parameter.\n"],["crush","Fattura24::Utils","Fattura24/Utils.html#method-c-crush","(obj)","<p>This function deeply removes any nil object/value from objects.\n"],["crush_array","Fattura24::Utils","Fattura24/Utils.html#method-c-crush_array","(array)","<p>Deeply removes any nil value from arrays.\n"],["crush_hash","Fattura24::Utils","Fattura24/Utils.html#method-c-crush_hash","(hash)","<p>Deeply removes any nil value from hashes.\n"],["get_file","Fattura24::Api","Fattura24/Api.html#method-c-get_file","(id)","<p>Donwloads a pdf file for an existing document. Requires an existing document id, throws MissingInput …\n"],["get_numerator","Fattura24::Api","Fattura24/Api.html#method-c-get_numerator","()","<p>Gets numerator list. Returns a Response object.\n"],["get_pdc","Fattura24::Api","Fattura24/Api.html#method-c-get_pdc","()","<p>Gets &#39;piano dei conti&#39; Returns a Response object.\n"],["get_product","Fattura24::Api","Fattura24/Api.html#method-c-get_product","(options = {})","<p>Gets a list of products. You can pass a Hash containing a <code>code</code> or <code>category</code> to filter your existing products …\n"],["get_template","Fattura24::Api","Fattura24/Api.html#method-c-get_template","()","<p>Gets a list of document templates. Returns a Response object.\n"],["message","Fattura24::MissingApiKey","Fattura24/MissingApiKey.html#method-i-message","()",""],["new","Fattura24::Api::Response","Fattura24/Api/Response.html#method-c-new","(http_response)",""],["new","Fattura24::Configuration","Fattura24/Configuration.html#method-c-new","()",""],["pdf?","Fattura24::Api::Response","Fattura24/Api/Response.html#method-i-pdf-3F","()","<p>Returns <code>true</code> when the body of the request contains a pdf file.\n"],["request","Fattura24::Api","Fattura24/Api.html#method-c-request","(path, body = {})","<p>Performs a generic request on the api endpoint using Ruby&#39;s Net::HTTP. All the other api methods …\n"],["save_customer","Fattura24::Api","Fattura24/Api.html#method-c-save_customer","(data = {})","<p>Saves a customer in your contact list. Any <code>nil</code> parameter will be deeply removed by using the crush utility. …\n"],["save_document","Fattura24::Api","Fattura24/Api.html#method-c-save_document","(data = {})","<p>Use this to create documents. Pass a hash with the data, check the README file for examples. Use DocumentType …\n"],["save_item","Fattura24::Api","Fattura24/Api.html#method-c-save_item","(data = {})","<p>Creates a credit. Any <code>nil</code> parameter will be deeply removed by using the crush utility. Returns a Response …\n"],["success?","Fattura24::Api::Response","Fattura24/Api/Response.html#method-i-success-3F","()","<p>Returns <code>true</code> when the http response is 200, <code>false</code> otherwise.\n"],["test_key","Fattura24::Api","Fattura24/Api.html#method-c-test_key","()","<p>Tests validity of your api key. Returns a Response object.\n"],["to_h","Fattura24::Api::Response","Fattura24/Api/Response.html#method-i-to_h","()","<p>Returns an hash representation of the xml body of the response. Raises NotSerializable in case of a binary …\n"],["to_s","Fattura24::Api::Response","Fattura24/Api/Response.html#method-i-to_s","()","<p>Returns the <code>String</code> body of this response. This can be both the original xml on most of the calls or the …\n"],["README","","README_md.html","","<p>Fattura24\n<p>Simple, lightweight and with minimal dependencies ruby 2 wrapper for the Fattura24 apis.\n<p>Tested …\n"]]}}