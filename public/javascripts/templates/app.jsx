module.exports = function () {
  var type_box_list = this.state.node_types.map((type) =>
      <TypeBox data={type} app={this} key={type._id}/>
  );

  return (
    <div className="app">
      <button onClick={this.newNodeType}>ADD</button>
      {type_box_list}
    </div>
  );
};
