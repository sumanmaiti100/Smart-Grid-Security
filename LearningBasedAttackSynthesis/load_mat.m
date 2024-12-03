function load_mat(myMat)
  data = load(myMat);
  cellfun(@(x,y) assignin('base',x,y),fieldnames(data),struct2cell(data));
  %assignin('base',data)
end