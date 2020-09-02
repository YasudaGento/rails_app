import moment from 'moment';
const NO_INPUT_MESSAGE = " 未入力";

const formatter = {
  datetime: function(d) { return formatter.is_empty(d) ? NO_INPUT_MESSAGE : moment(d).format("YY/MM/DD HH:mm") },

  is_empty: function(d) { return d === null || d === undefined || d === '' || d === [] }
}

export default formatter