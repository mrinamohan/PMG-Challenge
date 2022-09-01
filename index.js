const request = require("request");
const { parse } = require("csv-parse");
const fs = require("fs");
const readline = require("readline");
const stream = fs.createReadStream("./remove_backgrounds.csv");
const rl = readline.createInterface({ input: stream });
let data = [];
let image = [];

sourceImagePath="";
outputImagePath="";

rl.on("line", (row) => {
    data.push(row.split(","));
});
rl.on("close", () => {
    for(let i=1; i<data.length; i++){
        sourceImagePath = data[i][1];
        outputImagePath = "/Users/mrinalinimohanram/Dev/background\ removal/final\ images/output" + i + ".png"
    }
    console.log(sourceImagePath);
});
const settings = {
  url: "https://api.slazzer.com/v2.0/remove_image_background",
  apiKey: "8455e8127fde4ea48c74e611f9e914bb",
  sourceImagePath:sourceImagePath,
  outputImagePath:outputImagePath,
}
request.post(
  {
    url: settings.url,
    formData: {source_image_url: fs.createReadStream(settings.sourceImagePath),},
    headers: {"API-KEY": settings.apiKey,},
    encoding: null,
  },
  function (error, response, body) {
    if(error){ console.log(error); return;}
    if(response.statusCode != 200){ console.log(body.toString('utf8')); return; }
    fs.writeFileSync(settings.outputImagePath, body);
  }
);

/*fs.createReadStream("./remove_backgrounds.csv")
  .pipe(parse({ delimiter: ",", from_line:1}))
  .on("data", function (column2) {
    console.log(column2);
  })
/*var global_data = fs.createReadStream("./remove_backgrounds.csv").toString();
//calling the npm package and save to records
const records = parse(global_data, {
});

//map the output from csv-parse to the column
console.log(records);
const column_two = records.map(rec => rec["Image"]);
console.log(column_two);*/