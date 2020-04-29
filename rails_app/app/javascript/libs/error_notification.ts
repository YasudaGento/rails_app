import http from './http'
import * as moment from 'moment';

export default {
  // 関数名: to_slack
  // 引数：file_name: 発生場所のファイル, error: 発生したエラー内容
  to_slack: (error_info) => {
    let date =  moment(new Date()).format("YYYY/MM/DD HH:mm:ss"); 
    let url = location.href;
    const error_obj_msg = error_info["error_obj"] === undefined ? "設定されていません" : error_info["error_obj"]
    // 空白が混入するから、この形になっている（インデントのずれではない）
    let text = `発生時刻：${date.toString()}\n\エラーオブジェクト(error): ${error_obj_msg}\n\エラーメッセージ(error.response.data.messag): ${error_info["error"]}\n\ファイル名：${error_info["file_name"]}\n\関数名：${error_info["function_name"]}\n\URL：${url}\n`
    // エラーメッセージをconsoleに出力 
    console.log("エラーが発生しました！")
    console.log(text)
    //　送信
    http.post('/slacks/notificate', { error_log: text, })
        .then(() => {
          console.log("Slackのチャンネルにエラーメッセージを送信しました")
        })
        .catch((err) => {
          console.log("Slackのチャンネルにエラーメッセージを送信するのを失敗しました")      
          console.log("以下エラーメッセージ")   
          console.log(err)   
        });
  }
}