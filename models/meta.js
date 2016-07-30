const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const MetaSchema = new Schema({
	name: {type: String, default: '', trim: true},
	title: {type: String, default: '', trim: true}
});

mongoose.model('Meta', MetaSchema);

// const NodeType = mongoose.model('NodeType');
// _node_type = new NodeType({
// 	name: 'folder',
// 	title: 'Папка'
// });
// _node_type.save();