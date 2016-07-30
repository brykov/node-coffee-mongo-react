const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const Meta = mongoose.model('Meta');

router.get('/', (req, res, next) => {
  Meta.find({}).exec()
    .then(
      (data) => res.json({ meta_list: data }),
      (error) => console.log(error)
    );
});


router.post('/', (req, res, next) => {
  //console.log(req.body);
  promises = [];
  for(var item of req.body.node_types) {
    //console.log(item);
    if(item._new) {
      delete item._new;
      delete item._id;
      promises.push(Meta(item).save((err) => console.log(err)));
    }
    else {
      promises.push(Meta.update({_id: item._id}, item, (err, numberAffected, raw) => {
        console.log([err, numberAffected, raw]);
      }));
    }
  }
  Promise.all(promises).then(() => res.json({success: 'OK'}));
});

module.exports = router;
