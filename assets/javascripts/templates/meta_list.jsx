meta_list_jsx = function () {
  var type_box_list = this.props.data.map((meta) =>
      <MetaItemView data={meta} parent={this} key={meta._id}/>
  );

  return (
    <div className="meta-list">
      <button onClick={this.props.parent.newMeta}>ADD</button>
      {type_box_list}
    </div>
  );
};
