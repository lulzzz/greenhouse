<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>历史信息列表</title>
<%@ include file="/WEB-INF/jsp/public/commons.jspf" %>
<style type="text/css"> 
     body {
       margin: 0px;
      padding: 0px;
     }
     #container {
        width : 980px;
        height: 450px;
        left:50px;
        top:50px
      }	
     </style> 
</head>
<body>

<div id="container"> </div> 
 <script type="text/javascript" src="${pageContext.request.contextPath}/js/flotr2.min.js">  </script> 
     <script type="text/javascript"> 
     /*data,总标题，x轴标题，y轴标题，x轴坐标，y轴坐标，y轴最大值，y轴最小值  */
    function drawChart(data,ti,tiX,tiY,ticksX,ticksY,maxY,minY){
      var container = document.getElementById("container");
      var option = {
            colors: ['#00A8F0', '#C0D800', '#CB4B4B', '#4DA74D', '#9440ED','#8B8655'],  //线条的颜色
             ieBackgroundColor:'#3ec5ff',                    //选中时的背景颜色
             title:ti,               						 //标题
             subtitle:'',                          			 //子标题
             shadowSize:5,                                   //线条阴影
             defaultType:'lines',                            //图表类型,可选值:bars,bubbles,candles,gantt,lines,markers,pie,points,radar
          	 HtmlText:false,                                 //是使用html或者canvas显示 true:使用html  false:使用canvas
             fontColor:'#ff3ec5',                            //字体颜色
             fontSize:10,                                   //字体大小
             resolution:7.5,                                 //分辨率 数字越大越模糊
             parseFloat:true,                                //是否将数据转化为浮点型
           xaxis: {
               ticks:ticksX, // 自定义X轴
               minorTicks: null,
               showLabels:true,                              // 是否显示X轴刻度
               showMinorLabels:false,
               labelsAngle:45,                               //x轴文字倾斜角度
               title:tiX,                                    //x轴标题
               titleAngle:0,                                 //x轴标题倾斜角度
               noTicks: 3,                                   //当使用自动增长时,x轴刻度的个数
               minorTickFreq:null,                           
               tickFormatter: Flotr.defaultTickFormatter,    //刻度的格式化方式
               tickDecimals:2,                               //刻度小数点后的位数
               min:0,                                        //刻度最小值  X轴起点的值
               max:25,                                       //刻度最大值
               autoscale:true,
               autoscaleMargin:0,
               color:'#ff3ec5',                              //x轴刻度的颜色
               mode:'normal',
               timeFormat:null,                            
               timeMode:'UTC',                               //For UTC time ('local' for local time).
               timeUnit:'year',                              //时间单位 (millisecond, second, minute, hour, day, month, year) 
               scaling:'linear',                             //linear or logarithmic
               base:Math.E,
               titleAlign:'center',                          //标题对齐方式
               margin:true
           }, 
           x2axis:{ 
           },
           yaxis:{
                  //// =>  Y轴配置与X轴类似
                ticks:ticksY,
                	//[ [0,"0"], [10,"10"], [20,"20"], [30,"30"], [40,"40"],[50,"50"],[60,"60"],[70,"70"],[80,"80"],[90,"90"],[100,"100"] ],  
                minorTicks: null,      // =>  format: either [1, 3] or [[1, 'a'], 3]
                showLabels: true,      // =>  setting to true will show the axis ticks labels, hide otherwise
                showMinorLabels: false,// =>  true to show the axis minor ticks labels, false to hide
                labelsAngle: 0,        // =>  labels' angle, in degrees
                title: tiY,           // =>  axis title
                titleAngle: 90,        // =>  axis title's angle, in degrees
                noTicks: 0,            // =>  number of ticks for automagically generated ticks
                minorTickFreq: null,   // =>  number of minor ticks between major ticks for autogenerated ticks
                tickFormatter: Flotr.defaultTickFormatter, // =>  fn: number, Object ->  string
                tickDecimals: 'no',    // =>  no. of decimals, null means auto
                min:0,             // =>  min. value to show, null means set automatically
                max:maxY,             // =>  max. value to show, null means set automatically
                autoscale: false,      // =>  Turns autoscaling on with true
                autoscaleMargin: 0,    // =>  margin in % to add if auto-setting min/max
                color: null,           // =>  The color of the ticks
                scaling: 'linear',     // =>  Scaling, can be 'linear' or 'logarithmic'
                base: Math.E,
                titleAlign: 'center',
                margin: true           // =>  Turn off margins with false
           },
           y2axis:{
           },
           grid: {
                  color: '#545454',      // =>  表格外边框和标题以及所有刻度的颜色
                  backgroundColor: null, // =>  表格背景颜色
                  backgroundImage: null, // =>  表格背景图片
                  watermarkAlpha: 0.4,   // =>  水印透明度
                  tickColor: '#DDDDDD',  // =>  表格内部线条的颜色
                  labelMargin: 1,        // =>  margin in pixels
                  verticalLines: true,   // =>  表格内部是否显示垂直线条
                  minorVerticalLines: null, // =>  whether to show gridlines for minor ticks in vertical dir.
                  horizontalLines: true, // =>  表格内部是否显示水平线条
                  minorHorizontalLines: null, // =>  whether to show gridlines for minor ticks in horizontal dir.
                  outlineWidth: 1,       // =>  表格外边框的粗细
                  outline : 'nsew',      // =>  超出显示范围后的显示方式
                  circular: false        // =>  是否以环形的方式显示
           },
           mouse:{
                  track: true,          // =>  为true时,当鼠标移动到每个折点时,会显示折点的坐标
                  trackAll: true,       // =>  为true时,当鼠标在线条上移动时,显示所在点的坐标
                  position: 'se',        // =>  鼠标事件显示数据的位置 (default south-east)
                  relative: true,       // =>  当为true时,鼠标移动时,即使不在线条上,也会显示相应点的数据
                  trackFormatter: Flotr.defaultTrackFormatter, // =>  formats the values in the value box
                  margin: 5,             // =>  margin in pixels of the valuebox
                  lineColor: '#FF3F19',  // =>  鼠标移动到线条上时,点的颜色
                  trackDecimals: 0,      // =>  数值小数点后的位数
                  sensibility: 2,        // =>  值越小,鼠标事件越精确
                  trackY: true,          // =>  whether or not to track the mouse in the y axis
                  radius: 3,             // =>  radius半径
                  fillColor: null,       // =>  color to fill our select bar with only applies to bar and similar graphs (only bars for now)
                  fillOpacity: 0.4       // =>  opacity透明度
           }
        };
      // Draw Graph
      Flotr.draw(container, data, option);
    }    
     </script>  
     
     <script type="text/javascript"> 	   

	function getBj(){
    	var bj = [];
  		var i;
  		var j; 	
     	<s:iterator value="historyLine" status="status"> 
     	   i = <s:property value="#status.index"/>;
     	   bj[i] = [];	/*每次循环添加一个数组  */
    		<s:iterator value="top" id="inner" status="innerstatus">					
     		j = <s:property value="#innerstatus.index"/>;	
     		bj[i][j] = <s:property value="#inner.value" />;    
     		</s:iterator> 
		</s:iterator>		
		return bj; 
    }
    
    function getTicksX(){
    	var ticksX = [];
    	<s:iterator value="ticksX" id="tx" status="status">					
     		i = <s:property value="#status.index"/>;	
     		ticksX[i] = "<s:property value="tx" />";  
     	</s:iterator> 
     	return ticksX;
    }	

//每一条线是一个二维数组
 var bj = getBj();
 var bj1 = [];
 var bj2 = [];
 var bj3 = [];
 var bj4 = [];
 var bj5 = [];
 var bj6 = [];
 
/*  for(var k=0; k<bj.length; k++){
 	if(bj[k] != null){
 		 for(var i=0; i<bj[k].length; i++){
 			bj1[i] = [];
 		  	for(var j=0; j<2; j++){
 				bj1[i][0] = i+1;
 				bj1[i][1] = bj[k][i];	
 			}
 		}
 	}
 } */
 
 if(bj[0] != null){
 	 for(var i=0; i<bj[0].length; i++){
 		bj1[i] = [];
 		for(var j=0; j<2; j++){
 			bj1[i][0] = i+1;
 			bj1[i][1] = bj[0][i];	
 		}
 	}
 }

 if(bj[1] != null){
 	for(var i=0; i<bj[1].length; i++){
 	bj2[i] = [];
 		for(var j=0; j<2; j++){
 			bj2[i][0] = i+1;
 			bj2[i][1] = bj[1][i];	
 		}
 	}
 }
 
 if(bj[2] != null){
 	 for(var i=0; i<bj[2].length; i++){
 	 bj3[i] = [];
 		for(var j=0; j<2; j++){
 			bj3[i][0] = i+1;
 			bj3[i][1] = bj[1][i];	
 		}
 	}
 }
 
 if(bj[3] != null){
 	  for(var i=0; i<bj[3].length; i++){
 		bj4[i] = [];
 		for(var j=0; j<2; j++){
 			bj4[i][0] = i+1;
 			bj4[i][1] = bj[1][i];	
 		}
 	}
 }

if(bj[4] != null){
	 for(var i=0; i<bj[4].length; i++){
 		bj5[i] = [];
 		for(var j=0; j<2; j++){
 			bj5[i][0] = i+1;
 			bj5[i][1] = bj[1][i];	
 		}
	 }
}
 
 if(bj[5] != null){
 	 for(var i=0; i<bj[5].length; i++){
 		bj6[i] = [];
 		for(var j=0; j<2; j++){
 			bj6[i][0] = i+1;
 			bj6[i][1] = bj[1][i];	
 		}
 	}
 }
  var data ;
  //json
   data= [
     { data : bj1,label :'(1)' ,lines : { show : true }, points : { show : true }},
     { data : bj2, label :'(2)' ,lines : { show : true }, points : { show : true}},
     { data : bj3, label :'(3)' ,lines : { show : true }, points : { show : true}},
     { data : bj4, label :'(4)' ,lines : { show : true }, points : { show : true}},
     { data : bj5, label :'(5)' ,lines : { show : true }, points : { show : true}},
     { data : bj6, label :'(6)' ,lines : { show : true }, points : { show : true}}
   ];

   var equipmentKind = "${equipmentKind}";
   var dataKind = "${dataKind}";
   var totalTitle ;
   var ytitle = "";
   var xtitle = "日期";
   var ticksXArray = getTicksX();
   var ticksX = [];
   var ticksY;
   var maxY;
   var minY;
 
   function title(equipmentKind,dataKind){
		if(equipmentKind==1&&dataKind==1){totalTitle="一天前空气温度历史数据折线图";ytitle="摄氏度(℃)";return;} 
		if(equipmentKind==1&&dataKind==3){totalTitle="三天前空气温度历史数据折线图";ytitle="摄氏度(℃)";return;} 
		if(equipmentKind==1&&dataKind==7){totalTitle="一周前空气温度历史数据折线图";ytitle="摄氏度(℃)";return;} 
		if(equipmentKind==1&&dataKind==30){totalTitle="一个月前空气温度历史数据折线图";ytitle="摄氏度(℃)";return;} 
		if(equipmentKind==2&&dataKind==1){totalTitle="一天前空气湿度历史数据折线图";ytitle="百帕(hPa)";return;} 
		if(equipmentKind==2&&dataKind==3){totalTitle="三天前空气湿度历史数据折线图";ytitle="百帕(hPa)";return;} 
		if(equipmentKind==2&&dataKind==7){totalTitle="一周前空气湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==2&&dataKind==30){totalTitle="一个月空气湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==3&&dataKind==1){totalTitle="一天前土壤温度历史数据折线图";ytitle="摄氏度(℃)";return;} 	
		if(equipmentKind==3&&dataKind==3){totalTitle="三天前土壤温度历史数据折线图";ytitle="摄氏度(℃)";return;} 	
		if(equipmentKind==3&&dataKind==7){totalTitle="一周前土壤温度历史数据折线图";ytitle="摄氏度(℃)";return;} 	
		if(equipmentKind==3&&dataKind==30){totalTitle="一个月前土壤温度历史数据折线图";ytitle="摄氏度(℃)";return;} 	
		if(equipmentKind==4&&dataKind==1){totalTitle="一天前土壤湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==4&&dataKind==3){totalTitle="三天前土壤湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==4&&dataKind==7){totalTitle="一周前土壤湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==4&&dataKind==30){totalTitle="一个月前土壤湿度历史数据折线图";ytitle="百帕(hPa)";return;} 	
		if(equipmentKind==5&&dataKind==1){totalTitle="一天前光照强度历史数据折线图";ytitle="勒克斯(Lux)";return;} 	
		if(equipmentKind==5&&dataKind==3){totalTitle="三天前光照强度历史数据折线图";ytitle="勒克斯(Lux)";return;} 	
		if(equipmentKind==5&&dataKind==7){totalTitle="一周前光照强度历史数据折线图";ytitle="勒克斯(Lux)";return;} 	
		if(equipmentKind==5&&dataKind==30){totalTitle="一个月前光照强度历史数据折线图";ytitle="勒克斯(Lux)";return;} 	
		if(equipmentKind==6&&dataKind==1){totalTitle="一天前二氧化碳历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==6&&dataKind==3){totalTitle="三天前二氧化碳历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==6&&dataKind==7){totalTitle="一周前二氧化碳历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==6&&dataKind==30){totalTitle="一个月前二氧化碳历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==7&&dataKind==1){totalTitle="一天前氨气浓度历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==7&&dataKind==3){totalTitle="三天前氨气浓度历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==7&&dataKind==7){totalTitle="一周前氨气浓度历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==7&&dataKind==30){totalTitle="一个月前氨气浓度历史数据折线图";ytitle="ppm";return;} 	
		if(equipmentKind==8&&dataKind==1){totalTitle="一天前土壤PH历史数据折线图";return;} 	
		if(equipmentKind==8&&dataKind==3){totalTitle="三天前土壤PH历史数据折线图";return;} 	
		if(equipmentKind==8&&dataKind==7){totalTitle="一周前土壤PH历史数据折线图";return;} 	
		if(equipmentKind==8&&dataKind==30){totalTitle="一个月前土壤PH历史数据折线图";return;}
	}
   title(equipmentKind,dataKind);
   
   for(var i=0; i<ticksXArray.length; i++){
   		ticksX[i] = [];
   		for(var j=0; j<2; j++){
   			ticksX[i][0] = i+1;
   			ticksX[i][1] = ticksXArray[i];
   		}
   }
   ticksY = [ [0,"0"], [10,"10"], [20,"20"], [30,"30"], [40,"40"],[50,"50"],[60,"60"],[70,"70"],[80,"80"],[90,"90"],[100,"100"] ];
   maxY = 100;
   minY = 1;          
     /*data,总标题，x轴标题，y轴标题，x轴坐标，y轴坐标，y轴最大值，y轴最小值  */
	   drawChart(
			   data,
			   totalTitle,
			   xtitle,
			   ytitle,
			   ticksX,
			   ticksY,
			   maxY,//Y轴的最大值,
			   minY//Y轴的最小值   
			   );
     </script> 
<!-- 
 <ul class="imglist">
    <s:iterator value="recordList">
    <li class="selected">
    <span><img src="images/img01.png" /></span>
    <h2><a href="test.html">${name}</a></h2>
    <p><s:a action="history_editUI?id=%{id}" cssClass="tablelink" target="popFrm" 
                    			onclick="window.parent.document.getElementById('popFrm').style.height='170px';">编辑</s:a>
	<s:a action="history_delete?id=%{id}" cssClass="tablelink" 
								onclick="window.parent.document.getElementById   ('popFrm').style.height=0;return confirm('确定要删除吗？')">删除</s:a>
	</p>
    </li>
    </s:iterator> 
  </ul>

<div class="listDiv">
	 	<table class="tablelist">
			<thead>        
				<tr>
					<th>登录名</th>
					<th>姓名</th>
					<th style="width:300px;">岗位</th>
					<th>备注</th>
					<th style="width:150px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="recordList">
					<tr>
						<td>${loginName}</td>
						<td>${name}</td>
						<td style="width:300px;">
							<s:iterator value="roles">
                				${name}
                			</s:iterator></td>
                		<td>${description}&nbsp;</td>
						<td style="width:150px;">
                    		<s:a action="history_editUI?id=%{id}" cssClass="tablelink" target="popFrm" 
                    			onclick="window.parent.document.getElementById('popFrm').style.height='170px';">编辑</s:a>
							<s:a action="history_delete?id=%{id}" cssClass="tablelink" 
								onclick="window.parent.document.getElementById   ('popFrm').style.height=0;return confirm('确定要删除吗？')">删除</s:a>
						</td>
					</tr>
				</s:iterator> 
 	</tbody>
		</table> 
</div>-->
<!-- 分页信息 -->
	 <s:form action="history_list"></s:form>
</body>

</html>
