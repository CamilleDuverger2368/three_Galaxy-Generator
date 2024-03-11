uniform float uSize;
uniform float uBrightness;
uniform float uTime;

attribute float aScale;
attribute vec3 aRandomness;

varying vec3 vColor;
varying float vBrightness;

void main()
{
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Rotation
    float angle = atan(modelPosition.x, modelPosition.z);
    float distanceCenter = length(modelPosition.xz);
    float angleOffset = (1.0 / distanceCenter) * uTime * 0.2;
    angle += angleOffset;
    modelPosition.x = cos(angle) * distanceCenter;
    modelPosition.z = sin(angle) * distanceCenter;

    // Randomness
    modelPosition.xyz += aRandomness;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    gl_Position = projectedPosition;

    // Taille
    gl_PointSize = uSize * aScale;
    gl_PointSize *= (1.0 / - viewPosition.z);

    // Varying updates
    vColor = color;
    vBrightness = uBrightness;
}