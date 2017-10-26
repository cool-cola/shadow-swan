uniform int tonemap;

vec3 linearToneMapping(vec3 color)
{
    float exposure = 1.;
    color = clamp(exposure * color, 0., 1.);
    return color;
}

vec3 simpleReinhardToneMapping(vec3 color)
{
    float exposure = 1.5;
    color *= exposure/(1. + color / exposure);
    return color;
}

vec3 lumaBasedReinhardToneMapping(vec3 color)
{
    float luma = dot(color, vec3(0.2126, 0.7152, 0.0722));
    float toneMappedLuma = luma / (1. + luma);
    color *= toneMappedLuma / luma;
    return color;
}

vec3 RomBinDaHouseToneMapping(vec3 color)
{
    color = exp( -1.0 / ( 2.72*color + 0.15 ) );
    return color;
}

vec3 filmicToneMapping(vec3 color)
{
    color = max(vec3(0.), color - vec3(0.004));
    color = (color * (6.2 * color + .5)) / (color * (6.2 * color + 1.7) + 0.06);
    return color;
}

vec3 Uncharted2ToneMapping(vec3 color)
{
    float A = 0.15;
    float B = 0.50;
    float C = 0.10;
    float D = 0.20;
    float E = 0.02;
    float F = 0.30;
    float W = 11.2;
    float exposure = 2.;
    color *= exposure;
    color = ((color * (A * color + C * B) + D * E) / (color * (A * color + B) + D * F)) - E / F;
    float white = ((W * (A * W + C * B) + D * E) / (W * (A * W + B) + D * F)) - E / F;
    color /= white;
    return color;
}

vec3 tonemapAuto(vec3 color)
{
#ifdef HDR_TONEMAP
    switch (tonemap) {
    case 0:
        color = linearToneMapping(color);
        break;
    case 1:
        color = simpleReinhardToneMapping(color);
        break;
    case 2:
        color = lumaBasedReinhardToneMapping(color);
        break;
    case 3:
        color = RomBinDaHouseToneMapping(color);
        break;
    case 4:
        color = filmicToneMapping(color);
        break;
    case 5:
        color = Uncharted2ToneMapping(color);
        break;
    }
#endif

#ifdef GAMMA_CORRECT
    color = pow(color, vec3(1.0 / 2.2));
#endif

    return color;
}