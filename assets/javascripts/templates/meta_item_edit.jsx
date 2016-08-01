module.exports = function () {
  return (
    <div className="meta-item">
      <div>id: <FancyInput parent={this} name="name"/></div>
      <div>title: <FancyInput parent={this} name="title"/></div>
      <button onClick={this.save}>SAVE</button>
      <button onClick={this.cancel}>CANCEL</button>
    </div>
  );
};