meta_item_view_jsx = function () {
  return (
    <div className="meta-item">
      {this.props.data.name}
      /
      {this.props.data.title}
      <button onClick={this.editMode}>EDIT</button>
    </div>
  );
};