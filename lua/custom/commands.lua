vim.api.nvim_create_user_command('ScaffoldRNScreen', function()
  local filename = vim.fn.expand '%:t:r' -- get filename without extension
  local lines = {
    "import React from 'react';",
    "import { View, Text, StyleSheet } from 'react-native';",
    '',
    'const ' .. filename .. ' = () => {',
    '  return (',
    '    <View style={styles.container}>',
    '      <Text>Hello from ' .. filename .. '!</Text>',
    '    </View>',
    '  );',
    '};',
    '',
    'const styles = StyleSheet.create({',
    '  container: {',
    '    flex: 1,',
    "    justifyContent: 'center',",
    "    alignItems: 'center',",
    '  },',
    '});',
    '',
    'export default ' .. filename .. ';',
  }

  -- Only scaffold if file is empty
  if vim.fn.line '$' == 1 and vim.fn.getline(1) == '' then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  else
    print 'Buffer is not empty. Scaffold skipped.'
  end
end, {})

vim.api.nvim_create_user_command('ScaffoldReduxThunk', function(opts)
  local name = opts.args
  local lines = {
    '',
    'export const ' .. name .. ' = createAsyncThunk(',
    "  '" .. name .. "',",
    '  async (_, thunkAPI) => {',
    '    try {',
    '      // your logic here',
    '    } catch (error) {',
    '      return thunkAPI.rejectWithValue({ error });',
    '    }',
    '  }',
    ');',
    '',
  }
  vim.api.nvim_put(lines, 'l', true, true)
end, { nargs = 1, desc = 'Scaffold a Redux Async Thunk function' })

vim.api.nvim_create_user_command('ScaffoldReduxBuilder', function(opts)
  local name = opts.args
  local lines = {
    '',
    '// ' .. name .. ' extra reducers',
    'builder.addCase(' .. name .. '.pending, (state) => {',
    '  state.loading.' .. name .. ' = true;',
    '})',
    'builder.addCase(' .. name .. '.fulfilled, (state, action) => {',
    '  state.loading.' .. name .. ' = false;',
    '  if (action.payload) {',
    '    // your fulfilled logic here',
    '  }',
    '})',
    'builder.addCase(' .. name .. '.rejected, (state, action) => {',
    '  state.loading.' .. name .. ' = false;',
    '  state.error = action.error;',
    '})',
    '',
  }
  vim.api.nvim_put(lines, 'l', true, true)
end, { nargs = 1, desc = 'Scaffold Redux Builder cases' })
