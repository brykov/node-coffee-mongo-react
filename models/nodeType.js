const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const NodeTypeSchema = new Schema({
	name: {type: String, default: '', trim: true},
	title: {type: String, default: '', trim: true}
});

mongoose.model('NodeType', NodeTypeSchema);

// const NodeType = mongoose.model('NodeType');
// _node_type = new NodeType({
// 	name: 'folder',
// 	title: 'Папка'
// });
// _node_type.save();