app_jsx = function () {
  var _render = <MetaList data={this.state.meta_list} parent={this}/>;
  if(this.state.edit_meta_item!==null) {
    _render = <MetaItemEdit data={this.state.meta_list[this.state.edit_meta_item]} parent={this}/>
  }
  return (
    <div className="app">
      {_render}
    </div>
  );
};
