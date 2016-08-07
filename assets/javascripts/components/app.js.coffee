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
    app_jsx.bind(@)()