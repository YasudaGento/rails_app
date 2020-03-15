import axios from 'axios'

export default {
  fetch: function (url: string, params: object) {
    return axios.get(url, params)
  },

  post: function (url: string, params: object) {
    axios.defaults.headers['X-CSRF-TOKEN'] = $('meta[name=csrf-token]').attr('content')
    return axios.post(url, params)
  },
}