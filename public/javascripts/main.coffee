rr = require

class window.FancyInput extends React.Component
  changeHandler: (e) =>
    data = @state.data
    data[@props.name] = e.target.value
    @setState data: data
  render: =>
    rr('fancy_input').bind(@)()


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
    rr('meta_item_view').bind(@)()

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
    rr('meta_item_edit').bind(@)()

class window.MetaList extends React.Component
  render: =>
    rr('meta_list').bind(@)()


class window.App extends React.Component
  componentWillMount: =>
    @setState { meta_list: [], edit_meta_item: null }
  newMeta: =>
    list = @state.meta_list
    new_idx = list.push(
      _id: (new Date).valueOf()
      _new: true
      name: ''
      title: ''
    ) - 1
    @setState meta_list: list, edit_meta_item: new_idx
  delMeta: (el) =>
    list = @state.meta_list
    list.splice list.indexOf(el), 1
    @setState meta_list: list
  loadMetas: =>
    qwest.get('/meta_list').then (xhr, response) =>
      @setState meta_list: response['meta_list']
      #console.log(response);
  componentDidMount: =>
    @loadMetas()
  save: =>
    qwest.post('/meta_list', {meta_list: @state.meta_list}, dataType: 'json').then((xhr, response) =>
      #console.log([xhr, response]);
      if response.success == 'OK'
        @loadMetas()
    ).catch (e, xhr, response) ->
      #console.log([e, xhr, response]);
  render: =>
    rr('app').bind(@)()



ReactDOM.render React.createElement(App), document.getElementById('react-app')
