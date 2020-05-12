 // get the input data to be transformed
 var input = context.getVariable('request.content');
 // parse and modify the JSON content
 var arr = JSON.parse(input, function(key, value) {
     
    if (!(value instanceof Array)) {
        
        switch(key) {
            case 200:
             this["code_200"] = value;
             return;
            case 201:
             this["code_201"] = value;
             return;
            case 202:
             this["code_202"] = value;
             return;
            case 203:
             this["code_203"] = value;
             return;
            case 204:
             this["code_204"] = value;
             return;
            case 301:
             this["code_301"] = value;
             return;
            case 302:
             this["code_302"] = value;
             return;
            case 304:
             this["code_304"] = value;
             return;
            case 400:
             this["code_400"] = value;
             return;
            case 401:
             this["code_401"] = value;
             return;
            case 403:
             this["code_403"] = value;
             return;
            case 404:
             this["code_404"] = value;
             return;
            case 405:
             this["code_405"] = value;
             return;
            case 415:
             this["code_415"] = value;
             return;
            case 500:
             this["code_500"] = value;
             return;
            case 501:
             this["code_501"] = value;
             return;
            case 502:
             this["code_502"] = value;
             return;
            case 503:
             this["code_503"] = value;
             return;
            case 504:
             this["code_504"] = value;
             return;
            default:
             return value;
            }
        // adapat empty array with a default "" value if necessary
        } else if(value instanceof Array && value.length <= 0) {
            return new Array("");
        } else {
            return value;
        }
 });
 // set the response (no target)
 context.setVariable('request.content',JSON.stringify(arr));
 