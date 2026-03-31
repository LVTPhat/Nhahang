const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
admin.initializeApp();
let transporter = nodemailer.createTransport({
service: 'gmail',
auth: {
user: 'vothien220518@gmail.com',
pass: 'thien220518'  //you your password
}
});
exports.sendMail = functions.https.onRequest((req, res) => {
cors(req, res, () => {
// getting dest email by query string
const dest = req.query.dest;
const mailOptions = {
from: 'Agile Developers <agile.developers1804@gmail.com>', // 
to: dest,
subject: 'Welcome to ABC', // email subject
html: `Dear User, Welcome to ABC, <p>thank you for choosing us      `
};
// returning result
return transporter.sendMail(mailOptions, (erro, info) => {
if(erro){
return res.send(erro.toString());
}
return res.send('Sended');
});
});
});

