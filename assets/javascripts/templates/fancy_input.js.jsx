fancy_input_jsx = function() {
  return(<input type="text" defaultValue={this.props.parent.props.data[this.props.name]} onChange={this.changeHandler}/>);
}