const nodemailer = require('nodemailer');

const password = 'qbru dtcf xhih uios';

send = (sender, receiver, message) =>
{
    const transporter = nodemailer.createTransport({
        host: 'smtp.gmail.com',
        port: 587,
        secure: false,
        service: 'Gmail',
        auth: {
            user: sender,
            pass: password
        }
    });

    const mailOptions = {
        from: sender,
        to: receiver,
        subject: 'Module m0306',
        text: message
    }

    transporter.sendMail(mailOptions, (err, info) => {
        err ? console.log(err) : console.log('Sent: ' + info.response);
    })
}

module.exports = send;