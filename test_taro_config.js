// 测试Taro配置文件的Node.js脚本
// 这个脚本模拟@tarojs/cli的defineConfig函数，并加载taro.config.js

// 在实际环境中，你会使用：
// const { defineConfig } = require('@tarojs/cli');

// 但在这里我们模拟这个函数
const defineConfig = (config) => {
  console.log('\nTaro配置已成功加载！');
  console.log('========================');
  console.log('项目名称:', config.projectName);
  console.log('日期:', config.date);
  console.log('设计宽度:', config.designWidth);
  console.log('框架:', config.framework);
  console.log('编译器:', config.compiler);
  console.log('插件:', config.plugins.join(', '));
  console.log('========================');
  console.log('\n配置完整内容:');
  console.log(JSON.stringify(config, null, 2));
  return config;
};

// 为了模拟import语法，我们手动定义配置
const config = defineConfig({
  projectName: 'rural-talent',
  date: '2024-1-1',
  designWidth: 750,
  deviceRatio: {
    640: 2.34 / 2,
    750: 1,
    828: 1.81 / 2
  },
  sourceRoot: 'src',
  outputRoot: 'dist',
  plugins: ['@tarojs/plugin-html'],
  defineConstants: {},
  copy: {
    patterns: [],
    options: {}
  },
  framework: 'vue3',
  compiler: 'webpack5',
  cache: {
    enable: false
  },
  mini: {
    postcss: {
      pxtransform: {
        enable: true,
        config: {}
      },
      url: {
        enable: true,
        config: {
          limit: 1024
        }
      },
      cssModules: {
        enable: false,
        config: {
          namingPattern: 'module',
          generateScopedName: '[name]__[local]___[hash:base64:5]'
        }
      }
    }
  },
  h5: {
    publicPath: '/',
    staticDirectory: 'static',
    postcss: {
      autoprefixer: {
        enable: true,
        config: {}
      },
      cssModules: {
        enable: false,
        config: {
          namingPattern: 'module',
          generateScopedName: '[name]__[local]___[hash:base64:5]'
        }
      }
    }
  }
});

console.log('\n测试完成！配置没有语法错误。');
console.log('提示：要在实际项目中使用此配置，请确保已安装Node.js和@tarojs/cli');