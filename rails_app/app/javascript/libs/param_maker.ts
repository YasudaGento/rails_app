import Qs from "qs";
export default {
  get: function(params: object){
    return  {
      params,
      paramsSerializer: function (params) { return Qs.stringify(params, { arrayFormat: 'brackets' }); }
    }
  }
}