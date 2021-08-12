require'snippets'.use_suggested_mappings()
require'snippets'.snippets = {
  -- The _global dictionary acts as a global fallback.
  -- If a key is not found for the specific filetype, then
  --  it will be lookup up in the _global dictionary.
  _global = {
    -- Insert a basic snippet, which is a string.
    pdb = "import pdb; pdb.set_trace()";
    inm = [[
def main():
    pass


if __name__ == '__main__':
    main()]];
    pf = "print(f'$1')";
  }
}
