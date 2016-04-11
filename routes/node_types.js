const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const NodeType = mongoose.model('NodeType');

router.get('/', (req, res, next) => {
  NodeType.find({}).exec()
    .then(
      (data) => res.json({ node_types: data }),
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
      promises.push(NodeType(item).save((err) => console.log(err)));
    }
    else {
      promises.push(NodeType.update({_id: item._id}, item, (err, numberAffected, raw) => {
        console.log([err, numberAffected, raw]);
      }));
    }
  }
  Promise.all(promises).then(() => res.json({success: 'OK'}));
});

module.exports = router;
