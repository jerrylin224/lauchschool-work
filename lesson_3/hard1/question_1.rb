if false
  greeting = “hello world”
end

greeting


#greeting is nil here, and no "undefined method or local variable" exception is thrown.Typically, when you reference an uninitialized variable, Ruby will raise an exception, stating that it’s undefined.
#However, when you initialize a local variable within an if block, even if that if block doesn’t get executed, the local variable is initialized to nil.
