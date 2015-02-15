function [probs, scores, norms] = softmax(scores, varargin)
%%%
%
% Efficient (hopefully) softmax implementation.
% Return normalized probs as well as scores (numerators in log domain) & norms.
% Note that scores & norms are subtracted/scaled by a constant factor.
% If mask exists, mask out probs.
%
% Thang Luong @ 2015, <lmthang@stanford.edu>
% Hieu Pham @ 2015, <hyhieu@cs.stanford.edu>
%
%%%
  mx = max(scores);
  scores = bsxfun(@minus, scores, mx); % subtract max elements 
  probs = exp(scores); % unnormalized probs 
  norms = sum(probs); % normalization factors
  if length(varargin) == 1
    mask = varargin{1};
    probs = bsxfun(@times, probs, mask./norms); % normalize and zero out at masked positions
  else
    probs = bsxfun(@rdivide, probs, norms); % normalized probs
  end
end