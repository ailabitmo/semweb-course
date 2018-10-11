[QueryItem="getFullName"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?firstName ?lastName where { 
   ?person rdf:type :Person .
   ?person :firstName ?firstName . 
?person :lastName ?lastName . 
}

[QueryItem="getFirstName"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?firstName where { 
   ?person rdf:type :Person .
   ?person :firstName ?firstName . 
}

[QueryItem="getLastName"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?lastName where { 
   ?person rdf:type :Person .
?person :lastName ?lastName . 
}

[QueryItem="getAllBooks"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?title ?author where {
?book rdf:type :Book .
?book :bookTitle ?title .
?book :bookAuthor ?author
}

[QueryItem="getBooksFromSpecifiedLibrary"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?libraryTitle where {
?library rdf:type :Library .
?book rdf:type :Book .
?book :bookTitle "Капитанская дочка" .
?library :contains ?book .
?library :libraryTitle ?libraryTitle .
}

[QueryItem="getReadersRegisteredInSpecifiedLibrary"]
PREFIX : <http://www.semanticweb.org/dis/library-ontology#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>

select ?firstName ?lastName where {
?person rdf:type :Person .
?library rdf:type :Library .
?person :isRegisteredIn ?library .
?library :libraryTitle "Библиотека им. М. А. Булгакова" .
?person :firstName ?firstName .
?person :lastName ?lastName .
}
