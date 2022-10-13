const http = require("http");
const fs = require("fs");
const path = require("path");
const url = require("url");
const parseString = require('xml2js').parseString;

var formidable = require('formidable');

const port = 8080;

const server = http.createServer((req, res) => {
    const reqUrl = url.parse(req.url).pathname;

    if (reqUrl == "/") {
        res.write("Server del CiapoMelzun");
        res.end();
    }

    else if (reqUrl == "/comuni") {
        if (req.method == 'GET') {
            var xml = fs.readFileSync(path.resolve(__dirname, "./comuni.xml"), 'utf8');
            var comuni = '';
            parseString(xml, (err, data) => {
                if (err) {
                    console.log(err);
                } else {
                    comuni = data.comuni;
                }
            });

            res.setHeader("Content-Type", "application/xml");
            res.write("<comuni>")

            comuni.DATA_RECORD.forEach((data) => {
                res.write("<comune><id>" + data.ID[0] +
                    "</id><name>" + data.name[0] +
                    "</name><slug>" + data.slug[0] + "</slug><lat>" + data.lat[0] +
                    "</lat><lng>" + data.lng[0] + "</lng><codice_provincia_istat>" +
                    data.codice_provincia_istat[0] + "</codice_provincia_istat><codice_comune_istat>" +
                    data.codice_comune_istat[0] + "</codice_comune_istat><codice_alfanumerico_istat>" +
                    data.codice_alfanumerico_istat[0] + "</codice_alfanumerico_istat><capoluogo_provincia>" +
                    data.capoluogo_provincia[0] + "</capoluogo_provincia><capoluogo_regione>" +
                    data.capoluogo_regione[0] + "</capoluogo_regione>" +
                    "</comune>");
            })

            res.write("</comuni>")

            res.end();
        }
    }

    else if (reqUrl.indexOf("/images/CarPooling/") == 0) {
        var form = new formidable.IncomingForm();

        if (req.method == 'POST') {
            form.parse(req, function (err, fields, files) {
                var name = fields.nameImg;
                var oldpath = files.profileImg.filepath;
                var folder = req.url.split('/')[3];
                var newpath = '';

                switch (folder) {
                    case 'profile':
                        newpath = __dirname + '/img/CarPooling/profile/' + name;
                        break;

                    case 'idcard':
                        newpath = __dirname + '/img/CarPooling/idcard/' + name;
                        break;

                    case 'car':
                        newpath = __dirname + '/img/CarPooling/car/' + name;
                        break;

                    default:
                        res.statusCode = 400;
                        res.write('Error folder image')
                        res.end();
                        return;
                }

                fs.copyFile(oldpath, newpath, function (err) {
                    if (err) {
                        res.write('Error: ' + err.message);
                        res.end();
                    }
                });
                res.write('File uploaded and moved!');
                res.end();
            });
        }

        else if (req.method == 'GET') {
            var folder = reqUrl.split('/')[3] + '/' + reqUrl.split('/')[4];

            var filepath = __dirname + '/img/CarPooling/' + folder;

            var s = fs.createReadStream(filepath);
            s.on('open', function () {
                res.setHeader('Content-Type', 'image/' + reqUrl.split('.')[1]);
                s.pipe(res);
            });
            s.on('error', function () {
                res.statusCode = 404;
                res.write('Not found');
                res.end();
            });
        }
    }
});

server.listen(port, (error) => {
    if (error) {
        console.log("Something went wrong", error);
    } else {
        console.log("Server is listening on port", port);
    }
});
