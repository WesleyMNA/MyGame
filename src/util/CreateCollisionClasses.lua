function createCollisionClasses()
    WORLD:addCollisionClass("Player")
    WORLD:addCollisionClass("PlayerBullet")
    WORLD:addCollisionClass("Bomb")

    WORLD:addCollisionClass("Enemy")
    WORLD:addCollisionClass("EnemyBullet")

    WORLD:addCollisionClass("Ignore")
end
