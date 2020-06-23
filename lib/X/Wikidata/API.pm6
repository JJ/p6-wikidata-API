unit class X::Wikidata::API is Exception;
has $.error;

submethod BUILD( :$!error) {}

method message() {
    return "There's an error in the API request: $!error";
}