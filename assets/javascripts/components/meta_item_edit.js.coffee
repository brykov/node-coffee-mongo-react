class window.MetaItemEdit extends React.Component
  cancel: =>
    @props.parent.setState edit_meta_item: null
    #      editMode: false
    #      data: _.clone(@data_copy)
    if @props.data._new
      return @props.parent.delMeta(@props.data)
  save: =>
    console.log @props.parent
  render: =>
    meta_item_edit_jsx.bind(@)()

class window.MetaList extends React.Component
  render: =>
    meta_list_jsx.bind(@)()
