class window.MetaItemView extends React.Component
  editMode: =>
    @setState editMode: true
    @props.root.setState render: React.cloneElement(@)
  cancelEditMode: =>
    if @state.data._new
      return @props.root.delMeta(@state.data)
    @setState
      editMode: false
      data: _.clone(@data_copy)
  save: =>
    @props.root.save()
    @data_copy = _.clone(@state.data)
    @setState
      editMode: false
      _new: false
  componentDidMount: =>
    @data_copy = _.clone(@props.data)
  render: =>
    meta_item_view_jsx.bind(@)()
