const config = require('config');
const aws = require('aws-sdk');
const multer = require('multer');
const multerS3 = require('multer-s3');
// const path = require('path');
// const fs = require('fs');

const digitalOcean = config.get('digitalOcean');
const spacesEndpoint = new aws.Endpoint(digitalOcean.space);
const s3 = new aws.S3({
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
    endpoint: spacesEndpoint,
});

// const storage = multer.diskStorage({
//     destination: (req, file, cb) => {
//         const dir = path.normalize(`${__dirname}/../public/images`);
//         if (!fs.existsSync(dir)) {
//             fs.mkdirSync(dir, { recursive: true });
//         }
//         cb(null, dir);
//     },
//     filename: (req, file, cb) => {
//         let filetype = '';
//         switch (file.mimetype) {
//             case 'image/gif':
//                 filetype = 'gif';
//                 break;
//             case 'image/png':
//                 filetype = 'png';
//                 break;
//             case 'image/jpeg':
//                 filetype = 'jpg';
//                 break;
//             default:
//                 break;
//         }
//         cb(null, `image-${Date.now()}.${filetype}`);
//     },
// });

const storage = multerS3({
    s3,
    bucket: digitalOcean.bucket.name,
    acl: digitalOcean.bucket.acl,
    key: (req, file, cb) => {
        cb(null, `${digitalOcean.bucket.directory}/${file.originalname}`);
    },
});

module.exports = multer({ storage });
