module.exports = {
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": [
        "plugin:@typescript-eslint/eslint-recommended",
        'prettier/@typescript-eslint'
    ],
    "globals": {
        "Atomics": "readonly",
        "SharedArrayBuffer": "readonly"
    },
    "parserOptions": {
        "ecmaVersion": 2018,
        "sourceType": "module",
        'parser': '@typescript-eslint/parser',
    },
    "parser":  'vue-eslint-parser',
    "plugins": [
        "vue",
        "@typescript-eslint"
    ],
    "rules": {
    }
};