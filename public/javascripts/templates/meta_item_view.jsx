module.exports = function () {
  return (
    <div className="meta-item">
      {this.props.data.name}
      /
      {this.props.data.title}
      <button onClick={this.editMode}>EDIT</button>
    </div>
  );
};