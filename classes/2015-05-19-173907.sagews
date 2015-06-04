︠72f4b2fd-9309-47f8-9cfd-d6a852efd78d︠
g=(1,2,3,4)
print g[0:2]
︡8a2d1db5-27e0-4ce5-9f83-638fcaa3dda0︡{"stdout":"(1, 2)\n"}︡
︠9bbe8eb0-596f-4c2c-9733-83f62b55930b︠
x=[0, 1, 0, 50]
maxLength=2
x[:0]=([0]*(maxLength))
x
for i in range(maxLength,len(x)):
    #input_tuple=x[i:i+maxLength+1]    #input to weight function
    x[i-maxLength:i+1]
    x[i]

︡10ac77b1-0295-4ec9-9295-7d7369f20700︡{"stdout":"[0, 0, 0, 1, 0, 50]\n"}︡{"stdout":"[0, 0, 0]\n0\n[0, 0, 1]\n1\n[0, 1, 0]\n0\n[1, 0, 50]\n50\n"}︡
︠e6bfe06c-67ad-4597-9c14-16d882c920c8︠

a=Set(x)
a.intersection(Set([1]))
a
︡94cf0010-81cc-47b6-b8c2-1c655bebc47b︡{"stdout":"{1}\n"}︡{"stdout":"{0, 1, 50}\n"}︡
︠8363a0cb-78cf-4151-aac8-c7f084da2d13︠

if 'a' in d:
    d['a']+=3
else:
    d['a']=3
︡72c1bfca-e26f-4c23-bd7e-9ea03877d791︡
︠c60c96bb-46df-4e48-b3c5-0964fdd2abdb︠
print d
︡729806c5-7fab-4d76-8b8e-dc5264a9009c︡{"stdout":"{'a': 6}\n"}︡
︠47e78518-f57b-4132-bfb5-545c10ce4b76︠
d['e']=4
︡c793c9a7-8c74-40d1-b6ca-591ce2e6db58︡
︠664baac8-a149-41cb-a2a8-4c37eebd40bf︠
print d
︡27a2611a-7fc3-48b8-baa3-5dd118208afe︡{"stdout":"{'a': 3, 'e': 4}\n"}︡
︠e95fb703-2cd1-4909-8c46-241d0420ba92︠
S=[0,1]
for s in S:
    if s in x:
        x.remove(s)
x
︡a41f0f71-764a-4713-a916-7a2597b70f8b︡{"stdout":"[0, 0]\n"}︡
︠26b5af5c-24dd-4230-9219-0f1a1f36f31a︠
x
︡7fbcf7e5-60a6-41d0-83f2-8c08a02da271︡{"stdout":"[0, 0, 1, 0]\n"}︡
︠b6bab771-383e-4e8d-9c75-f864ec4c603a︠

for w in d:
    print d[w]
︡ddb1626e-c099-4b27-9b85-a63c8072ee96︡{"stdout":"3\n4\n"}︡
︠8bc3bff8-536c-49c8-9e0f-6152ca553052︠
r={}
if d: print 'df'
︡4ab46cac-89dd-4e38-8b20-cd58fbafdd18︡{"stdout":"df\n"}︡
︠92973da4-1be6-4b48-94c4-518d540010a0s︠


 0.5 is RealNumber

type(0.5)
︡c1109978-f26f-4ec7-a1bc-b52448aa85d1︡{"stdout":"False\n"}︡{"stdout":"<type 'sage.rings.real_mpfr.RealLiteral'>\n"}︡
︠9019d509-31c2-459f-a265-8d05a37d999e︠









