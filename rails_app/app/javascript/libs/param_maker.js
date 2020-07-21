import Qs from "qs";
export default {
    get: function(params){
        return {
	    params,
	    paramsSerializer: function (params) { return Qs.stringify(params, { arrayFormat: 'brackets' }); }
	}
    }
}
