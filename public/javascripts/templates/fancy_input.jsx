module.exports = function () {
  return(
    <input type="text" defaultValue={this.state.data[this.props.name]} onChange={this.changeHandler}/>
  );
};