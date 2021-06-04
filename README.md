# Adaptive-filtering-MMSE
Applying minimum mean squared error using adaptive filtering

Let's call a the ratio of the two variances (glabal over local)

mL is the local mean (that is the average of all pixels in a block)

If you do the math: f(x,y) = (1-a)g(x,y) + a*mL

So, instead of replacing the whole area of pixels with their mean (that is f(x,y) = mL) you now pick a weighted average between the original values and their mean. In this particular case, the weight is based on the ratio of the variances, but any other weight could be used. In other words, depending on a, the output now ranges between no filtering and median filtering.
