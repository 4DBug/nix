{ den, ... }: {
  den.aspects.bug = {
    includes = [
      den.provides.primary-user
      (den.provides.user-shell "fish")
      den.provides.home-manager
    ];
  };
}
