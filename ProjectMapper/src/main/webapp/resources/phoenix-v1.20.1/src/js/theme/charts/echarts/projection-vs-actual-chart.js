import {
  echartSetOption,
  handleTooltipPosition,
  tooltipFormatter
} from './echarts-utils';

// dayjs.extend(advancedFormat);

/* -------------------------------------------------------------------------- */
/*                             Echarts Total Sales                            */
/* -------------------------------------------------------------------------- */

const projectionVsActualChartInit = () => {
  const { getColor, getData, getPastDates } = window.phoenix.utils;
  const $projectionVsActualChartEl = document.querySelector(
    '.echart-projection-actual'
  );

  const dates = getPastDates(10);

  const data1 = [
    44485, 20428, 47302, 45180, 31034, 46358, 26581, 36628, 38219, 43256
  ];

  const data2 = [
    38911, 29452, 31894, 47876, 31302, 27731, 25490, 30355, 27176, 30393
  ];

  if ($projectionVsActualChartEl) {
    const userOptions = getData($projectionVsActualChartEl, 'echarts');
    const chart = window.echarts.init($projectionVsActualChartEl);

    const getDefaultOptions = () => ({
      color: [getColor('primary'), getColor('tertiary-bg')],
      tooltip: {
        trigger: 'axis',
        padding: [7, 10],
        backgroundColor: getColor('body-highlight-bg'),
        borderColor: getColor('border-color'),
        textStyle: { color: getColor('light-text-emphasis') },
        borderWidth: 1,
        transitionDuration: 0,
        axisPointer: {
          type: 'none'
        },
        position: (...params) => handleTooltipPosition(params),
        formatter: params => tooltipFormatter(params),
        extraCssText: 'z-index: 1000'
      },
      legend: {
        data: ['Projected revenue', 'Actual revenue'],
        right: 'right',
        width: '100%',
        itemWidth: 16,
        itemHeight: 8,
        itemGap: 20,
        top: 3,
        inactiveColor: getColor('quaternary-color'),
        textStyle: {
          color: getColor('body-color'),
          fontWeight: 600,
          fontFamily: 'Nunito Sans'
          // fontSize: '12.8px'
        }
      },
      xAxis: {
        type: 'category',
        // boundaryGap: false,
        axisLabel: {
          color: getColor('secondary-color'),
          formatter: value => window.dayjs(value).format('MMM DD'),
          interval: 3,
          fontFamily: 'Nunito Sans',
          fontWeight: 600,
          fontSize: 12.8
        },
        data: dates,
        axisLine: {
          lineStyle: {
            color: getColor('tertiary-bg')
          }
        },
        axisTick: false
      },
      yAxis: {
        axisPointer: { type: 'none' },
        // boundaryGap: false,
        axisTick: 'none',
        splitLine: {
          interval: 5,
          lineStyle: {
            color: getColor('secondary-bg')
          }
        },
        axisLine: { show: false },
        axisLabel: {
          fontFamily: 'Nunito Sans',
          fontWeight: 600,
          fontSize: 12.8,
          color: getColor('secondary-color'),
          margin: 20,
          verticalAlign: 'bottom',
          formatter: value => `$${value.toLocaleString()}`
        }
      },
      series: [
        {
          name: 'Projected revenue',
          type: 'bar',
          barWidth: '6px',
          data: data2,
          barGap: '30%',
          label: { show: false },
          itemStyle: {
            borderRadius: [2, 2, 0, 0],
            color: getColor('primary')
          }
        },
        {
          name: 'Actual revenue',
          type: 'bar',
          data: data1,
          barWidth: '6px',
          barGap: '30%',
          label: { show: false },
          z: 10,
          itemStyle: {
            borderRadius: [2, 2, 0, 0],
            color: getColor('info-bg-subtle')
          }
        }
      ],
      grid: {
        right: 0,
        left: 3,
        bottom: 0,
        top: '15%',
        containLabel: true
      },
      animation: false
    });

    echartSetOption(chart, userOptions, getDefaultOptions);
  }
};

export default projectionVsActualChartInit;
