︠72f4b2fd-9309-47f8-9cfd-d6a852efd78ds︠
g=(1,2,3,4)
print g[0:2]
︡8a2d1db5-27e0-4ce5-9f83-638fcaa3dda0︡{"stdout":"(1, 2)\n"}︡
︠9bbe8eb0-596f-4c2c-9733-83f62b55930bs︠
x=[0, 1, 0, 0, 0]
maxLength=2
x[:0]=([0]*(maxLength))
x
for i in range(maxLength,len(x)):
    #input_tuple=x[i:i+maxLength+1]    #input to weight function
    x[i-maxLength:i+1]
    x[i]

︡ca636e24-e854-431d-a00f-e0b77d921c45︡{"stdout":"[0, 0, 0, 1, 0, 0, 0]\n"}︡{"stdout":"[0, 0, 0]\n0\n[0, 0, 1]\n1\n[0, 1, 0]\n0\n[1, 0, 0]\n0\n[0, 0, 0]\n0\n"}︡
︠e6bfe06c-67ad-4597-9c14-16d882c920c8︠










