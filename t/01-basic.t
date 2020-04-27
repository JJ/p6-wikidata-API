use v6;
use Test;
use lib ('../lib','lib');
use Wikidata::API;

  my $query = q:to/END/;
SELECT ?person ?personLabel WHERE {
  
    ?person wdt:P69 wd:Q1232180 . 
    ?person wdt:P21 wd:Q6581072 . 
  
    SERVICE wikibase:label { 
      bd:serviceParam wikibase:language "en" .
    }
} ORDER BY ?personLabel
END
  
my $UGR-women = query( $query );
is $UGR-women.WHAT, (Hash), "Type OK";
is $UGR-women<head><vars>.WHAT, (Array), "Headers OK";
cmp-ok $UGR-women<results><bindings>.elems, ">", 1, "Results OK";

$query = q:to/END/;
SELECT ?recipe ?recipeLabel 
WHERE
{
  ?recipe wdt:P31?/wdt:P279* wd:Q219239;
            wdt:P527 wd:Q21546392.
  SERVICE wikibase:label { bd:serviceParam wikibase:language "en", "fr". }
}
ORDER BY UCASE(STR(?recipeLabel))
END

my $garlic-recipes = query( $query );
ok $garlic-recipes<results>, "Non-null results";
ok $garlic-recipes<results><bindings>[0], "There's a result";

done-testing;
