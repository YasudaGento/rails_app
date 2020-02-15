import axios from 'axios'

export default {
  fetch: function (url: string, params: object) {
    return axios.get(url, params)
  }
}