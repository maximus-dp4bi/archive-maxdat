create or replace function json_merge(obj1 variant, obj2 variant) 
  RETURNS VARIANT
  //returns array
  LANGUAGE JAVASCRIPT
AS
$$
return Object.assign(OBJ1, OBJ2);
$$
;



CREATE OR REPLACE FUNCTION control.json_merge_array(V array)
  RETURNS VARIANT
  //returns array
  LANGUAGE JAVASCRIPT
AS
$$
var rjson = {};
var rjsontemp = {};
rjson = V[0];

//var return_array = [];
for (i=1;i<V.length;i++) {
//    return_array.push(typeof(V[i-1]));
    if (i==1) {rjson = (V[i-1]);}

//    return_array.push(JSON.stringify(rjson));
    rjsontemp = (V[i]);
    rjson = Object.assign((rjson),rjsontemp);


}
//    return_array.push(JSON.stringify(rjson));
  return rjson;
$$
;

