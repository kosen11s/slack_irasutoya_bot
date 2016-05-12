module.exports = (robot) ->
  dic = {
    "インターネット": [
      "https://3.bp.blogspot.com/-J47PcU-b-K4/VyNc1WokhII/AAAAAAAA6I4/ISH5eYg3LaI7UdDY1XYUawYAXi_iLa7-ACLcB/s450/regulation_tv_anshin.png"
      "https://4.bp.blogspot.com/-CU513qsWJ0M/VwzrDrlH01I/AAAAAAAA5o8/wqIEe2vjcqAvWYihn9gfUow2_Y4uKDEqQCLcB/s450/net_sns_iyagarase_man.png"
    ]
    "コンピュータ": [
      "https://1.bp.blogspot.com/-4VADHoGYDHs/Vw5KYSjriyI/AAAAAAAA5rc/TTfaLbrp9LUi0F43M7cs_EEO1BngO7rjQCLcB/s260/computer_trackpoint_softdome.png"
      "https://1.bp.blogspot.com/-uc_ylx1Sfn8/VxTa5y0CHdI/AAAAAAAA5-8/_XAyKD93apgTdO2Mp6eelg19vC7GfMnPwCLcB/s450/desinger_free_sozai.png"
    ]
  }

  for k, v of dic
    do (v) ->
      robot.hear ///#{k}///i, (res) ->
        res.send res.random(v)
