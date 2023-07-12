require 'json'
my_hash = { hello: "goodbye" }
puts JSON.generate(my_hash) #=> "{"hello":"goodbye"}"
puts  my_hash.to_json #=> "{"hello":"goodbye"}"
person = '{"name":"Jennifer Lopez","street":"641 Pine St.","phone":true,"age":50,"pets":["cat","dog","fish"]}'
parsed_person = JSON.parse(person) #=> {"name"=>"Jennifer Lopez", "street"=>"641 Pine St.", "phone"=>true, "age"=>50, "pets"=>["cat", "dog", "fish"]}
puts parsed_person
puts parsed_person['pets']